<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Macro Calculator - Fuel Your Gains</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Oswald:wght@300;400;600;700&family=Work+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #ff4655;
            --primary-dark: #e6334a;
            --secondary: #00d4ff;
            --bg-dark: #0a0e27;
            --bg-card: #131829;
            --bg-input: #1a1f3a;
            --text-primary: #ffffff;
            --text-secondary: #a0aec0;
            --text-muted: #718096;
            --accent-green: #00ff88;
            --accent-yellow: #ffd700;
            --gradient-fire: linear-gradient(135deg, #ff4655 0%, #ff8a00 100%);
            --gradient-ice: linear-gradient(135deg, #00d4ff 0%, #0099ff 100%);
            --shadow-glow: 0 0 30px rgba(255, 70, 85, 0.3);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Work Sans', sans-serif;
            background: var(--bg-dark);
            color: var(--text-primary);
            line-height: 1.6;
            overflow-x: hidden;
        }

        /* Animated Background */
        .bg-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 80%, rgba(255, 70, 85, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(0, 212, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(0, 255, 136, 0.05) 0%, transparent 50%);
            z-index: 0;
            pointer-events: none;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 20px;
            position: relative;
            z-index: 1;
        }

        /* Header */
        .header {
            text-align: center;
            margin-bottom: 60px;
            animation: fadeInDown 0.8s ease-out;
        }

        .header h1 {
            font-family: 'Bebas Neue', cursive;
            font-size: clamp(3rem, 8vw, 6rem);
            letter-spacing: 3px;
            background: var(--gradient-fire);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
            text-transform: uppercase;
            position: relative;
            display: inline-block;
        }

        .header h1::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: var(--gradient-fire);
            border-radius: 2px;
        }

        .header p {
            font-size: 1.2rem;
            color: var(--text-secondary);
            font-weight: 300;
            margin-top: 20px;
            letter-spacing: 1px;
        }

        /* Main Grid */
        .main-grid {
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 30px;
            animation: fadeInUp 0.8s ease-out 0.2s both;
        }

        /* Calculator Card */
        .calculator-card {
            background: var(--bg-card);
            border-radius: 20px;
            padding: 40px;
            border: 1px solid rgba(255, 255, 255, 0.05);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
            position: relative;
            overflow: hidden;
        }

        .calculator-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: var(--gradient-fire);
        }

        .section-title {
            font-family: 'Oswald', sans-serif;
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 2px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-title i {
            color: var(--primary);
            font-size: 1.5rem;
        }

        /* Form Groups */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            margin-bottom: 30px;
        }

        .form-group {
            position: relative;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-label {
            display: block;
            margin-bottom: 10px;
            color: var(--text-secondary);
            font-size: 0.9rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .input-wrapper {
            position: relative;
        }

        .form-input {
            width: 100%;
            padding: 15px 20px;
            background: var(--bg-input);
            border: 2px solid transparent;
            border-radius: 12px;
            color: var(--text-primary);
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            font-family: 'Work Sans', sans-serif;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 20px rgba(255, 70, 85, 0.2);
            transform: translateY(-2px);
        }

        .input-unit {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-weight: 600;
            pointer-events: none;
        }

        /* Gender Selection */
        .gender-selection {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .gender-option {
            position: relative;
        }

        .gender-option input[type="radio"] {
            position: absolute;
            opacity: 0;
        }

        .gender-label {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 18px;
            background: var(--bg-input);
            border: 2px solid transparent;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .gender-label i {
            font-size: 1.3rem;
        }

        .gender-option input[type="radio"]:checked + .gender-label {
            background: rgba(255, 70, 85, 0.1);
            border-color: var(--primary);
            box-shadow: 0 0 20px rgba(255, 70, 85, 0.2);
        }

        .gender-option:nth-child(1) input[type="radio"]:checked + .gender-label {
            border-color: var(--secondary);
            background: rgba(0, 212, 255, 0.1);
            box-shadow: 0 0 20px rgba(0, 212, 255, 0.2);
        }

        /* Activity Level */
        .activity-grid {
            display: grid;
            gap: 12px;
        }

        .activity-option {
            position: relative;
        }

        .activity-option input[type="radio"] {
            position: absolute;
            opacity: 0;
        }

        .activity-label {
            display: block;
            padding: 16px 20px;
            background: var(--bg-input);
            border: 2px solid transparent;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .activity-label .activity-name {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 4px;
            display: block;
        }

        .activity-label .activity-desc {
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .activity-option input[type="radio"]:checked + .activity-label {
            background: rgba(255, 70, 85, 0.1);
            border-color: var(--primary);
            box-shadow: 0 0 20px rgba(255, 70, 85, 0.2);
            transform: translateX(5px);
        }

        /* Goal Selection */
        .goal-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
        }

        .goal-option {
            position: relative;
        }

        .goal-option input[type="radio"] {
            position: absolute;
            opacity: 0;
        }

        .goal-label {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
            padding: 25px 15px;
            background: var(--bg-input);
            border: 2px solid transparent;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
        }

        .goal-label i {
            font-size: 2rem;
            margin-bottom: 5px;
        }

        .goal-label .goal-name {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 1px;
        }

        .goal-option:nth-child(1) input[type="radio"]:checked + .goal-label {
            border-color: var(--secondary);
            background: rgba(0, 212, 255, 0.1);
            box-shadow: 0 0 20px rgba(0, 212, 255, 0.2);
        }

        .goal-option:nth-child(2) input[type="radio"]:checked + .goal-label {
            border-color: var(--accent-green);
            background: rgba(0, 255, 136, 0.1);
            box-shadow: 0 0 20px rgba(0, 255, 136, 0.2);
        }

        .goal-option:nth-child(3) input[type="radio"]:checked + .goal-label {
            border-color: var(--primary);
            background: rgba(255, 70, 85, 0.1);
            box-shadow: 0 0 20px rgba(255, 70, 85, 0.2);
        }

        /* Calculate Button */
        .calculate-btn {
            width: 100%;
            padding: 20px;
            background: var(--gradient-fire);
            border: none;
            border-radius: 12px;
            color: white;
            font-family: 'Oswald', sans-serif;
            font-size: 1.3rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 30px;
            box-shadow: 0 10px 30px rgba(255, 70, 85, 0.3);
            position: relative;
            overflow: hidden;
        }

        .calculate-btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .calculate-btn:hover::before {
            width: 300px;
            height: 300px;
        }

        .calculate-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(255, 70, 85, 0.5);
        }

        .calculate-btn:active {
            transform: translateY(-1px);
        }

        /* Results Card */
        .results-card {
            background: var(--bg-card);
            border-radius: 20px;
            padding: 40px;
            border: 1px solid rgba(255, 255, 255, 0.05);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .results-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: var(--gradient-ice);
        }

        .results-hidden {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
            min-height: 400px;
            color: var(--text-muted);
            text-align: center;
        }

        .results-hidden i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        .results-hidden p {
            font-size: 1.1rem;
        }

        .results-content {
            display: none;
        }

        .results-content.show {
            display: block;
            animation: fadeIn 0.5s ease-out;
        }

        /* Main Calorie Display */
        .main-result {
            text-align: center;
            padding: 40px;
            background: var(--bg-input);
            border-radius: 16px;
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
        }

        .main-result::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 30% 50%, rgba(255, 70, 85, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 70% 50%, rgba(0, 212, 255, 0.1) 0%, transparent 50%);
            pointer-events: none;
        }

        .main-result .result-label {
            font-size: 0.9rem;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 15px;
        }

        .main-result .result-value {
            font-family: 'Bebas Neue', cursive;
            font-size: 5rem;
            background: var(--gradient-fire);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1;
            margin-bottom: 10px;
        }

        .main-result .result-unit {
            font-size: 1.2rem;
            color: var(--text-muted);
        }

        /* Macro Breakdown */
        .macro-breakdown {
            display: grid;
            gap: 15px;
            margin-bottom: 30px;
        }

        .macro-item {
            background: var(--bg-input);
            padding: 20px;
            border-radius: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-left: 4px solid;
            transition: all 0.3s ease;
        }

        .macro-item:hover {
            transform: translateX(5px);
        }

        .macro-item.protein {
            border-left-color: var(--primary);
        }

        .macro-item.carbs {
            border-left-color: var(--secondary);
        }

        .macro-item.fats {
            border-left-color: var(--accent-yellow);
        }

        .macro-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .macro-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .macro-item.protein .macro-icon {
            background: rgba(255, 70, 85, 0.1);
            color: var(--primary);
        }

        .macro-item.carbs .macro-icon {
            background: rgba(0, 212, 255, 0.1);
            color: var(--secondary);
        }

        .macro-item.fats .macro-icon {
            background: rgba(255, 215, 0, 0.1);
            color: var(--accent-yellow);
        }

        .macro-details .macro-name {
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
            margin-bottom: 4px;
        }

        .macro-details .macro-desc {
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .macro-value {
            text-align: right;
        }

        .macro-value .value {
            font-family: 'Oswald', sans-serif;
            font-size: 2rem;
            font-weight: 600;
            line-height: 1;
        }

        .macro-value .unit {
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        /* BMI Display */
        .bmi-display {
            background: var(--bg-input);
            padding: 25px;
            border-radius: 12px;
            text-align: center;
        }

        .bmi-label {
            font-size: 0.9rem;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 10px;
        }

        .bmi-value {
            font-family: 'Oswald', sans-serif;
            font-size: 3rem;
            font-weight: 600;
            color: var(--accent-green);
            margin-bottom: 10px;
        }

        .bmi-category {
            display: inline-block;
            padding: 8px 20px;
            background: rgba(0, 255, 136, 0.1);
            border-radius: 20px;
            color: var(--accent-green);
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Info Box */
        .info-box {
            background: rgba(0, 212, 255, 0.05);
            border: 1px solid rgba(0, 212, 255, 0.2);
            border-radius: 12px;
            padding: 20px;
            margin-top: 30px;
        }

        .info-box .info-title {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 600;
            margin-bottom: 12px;
            color: var(--secondary);
        }

        .info-box p {
            color: var(--text-secondary);
            font-size: 0.95rem;
            line-height: 1.7;
        }

        /* Animations */
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        /* Responsive */
        @media (max-width: 968px) {
            .main-grid {
                grid-template-columns: 1fr;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .goal-grid {
                grid-template-columns: 1fr;
            }

            .header h1 {
                font-size: 3rem;
            }

            .main-result .result-value {
                font-size: 4rem;
            }
        }

        @media (max-width: 640px) {
            .calculator-card,
            .results-card {
                padding: 25px;
            }

            .gender-selection {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="bg-overlay"></div>
    
    <div class="container">
        <div class="header">
            <h1>Macro Calculator</h1>
            <p>Precision Nutrition for Peak Performance</p>
        </div>

        <div class="main-grid">
            <!-- Calculator Form -->
            <div class="calculator-card">
                <h2 class="section-title">
                    <i class="fas fa-dumbbell"></i>
                    Your Stats
                </h2>

                <form id="calculatorForm">
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">Age</label>
                            <div class="input-wrapper">
                                <input type="number" class="form-input" id="age" placeholder="25" min="15" max="100" required>
                                <span class="input-unit">years</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Gender</label>
                            <div class="gender-selection">
                                <div class="gender-option">
                                    <input type="radio" name="gender" id="male" value="male" checked>
                                    <label for="male" class="gender-label">
                                        <i class="fas fa-mars"></i>
                                        <span>Male</span>
                                    </label>
                                </div>
                                <div class="gender-option">
                                    <input type="radio" name="gender" id="female" value="female">
                                    <label for="female" class="gender-label">
                                        <i class="fas fa-venus"></i>
                                        <span>Female</span>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Weight</label>
                            <div class="input-wrapper">
                                <input type="number" class="form-input" id="weight" placeholder="75" min="30" max="300" step="0.1" required>
                                <span class="input-unit">kg</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Height</label>
                            <div class="input-wrapper">
                                <input type="number" class="form-input" id="height" placeholder="175" min="100" max="250" required>
                                <span class="input-unit">cm</span>
                            </div>
                        </div>

                        <div class="form-group full-width">
                            <label class="form-label">Activity Level</label>
                            <div class="activity-grid">
                                <div class="activity-option">
                                    <input type="radio" name="activity" id="sedentary" value="1.2">
                                    <label for="sedentary" class="activity-label">
                                        <span class="activity-name">Sedentary</span>
                                        <span class="activity-desc">Little to no exercise</span>
                                    </label>
                                </div>
                                <div class="activity-option">
                                    <input type="radio" name="activity" id="light" value="1.375">
                                    <label for="light" class="activity-label">
                                        <span class="activity-name">Lightly Active</span>
                                        <span class="activity-desc">Light exercise 1-3 days/week</span>
                                    </label>
                                </div>
                                <div class="activity-option">
                                    <input type="radio" name="activity" id="moderate" value="1.55" checked>
                                    <label for="moderate" class="activity-label">
                                        <span class="activity-name">Moderately Active</span>
                                        <span class="activity-desc">Moderate exercise 3-5 days/week</span>
                                    </label>
                                </div>
                                <div class="activity-option">
                                    <input type="radio" name="activity" id="very" value="1.725">
                                    <label for="very" class="activity-label">
                                        <span class="activity-name">Very Active</span>
                                        <span class="activity-desc">Hard exercise 6-7 days/week</span>
                                    </label>
                                </div>
                                <div class="activity-option">
                                    <input type="radio" name="activity" id="extra" value="1.9">
                                    <label for="extra" class="activity-label">
                                        <span class="activity-name">Extra Active</span>
                                        <span class="activity-desc">Very hard exercise & physical job</span>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group full-width">
                            <label class="form-label">Your Goal</label>
                            <div class="goal-grid">
                                <div class="goal-option">
                                    <input type="radio" name="goal" id="cut" value="cut">
                                    <label for="cut" class="goal-label">
                                        <i class="fas fa-fire"></i>
                                        <span class="goal-name">Cut</span>
                                    </label>
                                </div>
                                <div class="goal-option">
                                    <input type="radio" name="goal" id="maintain" value="maintain" checked>
                                    <label for="maintain" class="goal-label">
                                        <i class="fas fa-balance-scale"></i>
                                        <span class="goal-name">Maintain</span>
                                    </label>
                                </div>
                                <div class="goal-option">
                                    <input type="radio" name="goal" id="bulk" value="bulk">
                                    <label for="bulk" class="goal-label">
                                        <i class="fas fa-chart-line"></i>
                                        <span class="goal-name">Bulk</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="calculate-btn">
                        <span style="position: relative; z-index: 1;">Calculate Macros</span>
                    </button>
                </form>

                <div class="info-box">
                    <div class="info-title">
                        <i class="fas fa-info-circle"></i>
                        <span>Pro Tip</span>
                    </div>
                    <p>These calculations use the Mifflin-St Jeor equation for accuracy. Adjust based on your progress and listen to your body!</p>
                </div>
            </div>

            <!-- Results Section -->
            <div class="results-card">
                <div class="results-hidden" id="resultsPlaceholder">
                    <i class="fas fa-calculator"></i>
                    <p>Enter your stats and calculate<br>to see your personalized macros</p>
                </div>

                <div class="results-content" id="resultsContent">
                    <h2 class="section-title">
                        <i class="fas fa-chart-pie"></i>
                        Your Results
                    </h2>

                    <div class="main-result">
                        <div class="result-label">Daily Calorie Target</div>
                        <div class="result-value" id="totalCalories">0</div>
                        <div class="result-unit">calories/day</div>
                    </div>

                    <div class="macro-breakdown">
                        <div class="macro-item protein">
                            <div class="macro-info">
                                <div class="macro-icon">
                                    <i class="fas fa-drumstick-bite"></i>
                                </div>
                                <div class="macro-details">
                                    <div class="macro-name">Protein</div>
                                    <div class="macro-desc">Muscle building & repair</div>
                                </div>
                            </div>
                            <div class="macro-value">
                                <div class="value" id="proteinValue">0</div>
                                <div class="unit">grams</div>
                            </div>
                        </div>

                        <div class="macro-item carbs">
                            <div class="macro-info">
                                <div class="macro-icon">
                                    <i class="fas fa-bread-slice"></i>
                                </div>
                                <div class="macro-details">
                                    <div class="macro-name">Carbs</div>
                                    <div class="macro-desc">Energy & performance</div>
                                </div>
                            </div>
                            <div class="macro-value">
                                <div class="value" id="carbsValue">0</div>
                                <div class="unit">grams</div>
                            </div>
                        </div>

                        <div class="macro-item fats">
                            <div class="macro-info">
                                <div class="macro-icon">
                                    <i class="fas fa-bacon"></i>
                                </div>
                                <div class="macro-details">
                                    <div class="macro-name">Fats</div>
                                    <div class="macro-desc">Hormone production</div>
                                </div>
                            </div>
                            <div class="macro-value">
                                <div class="value" id="fatsValue">0</div>
                                <div class="unit">grams</div>
                            </div>
                        </div>
                    </div>

                    <div class="bmi-display">
                        <div class="bmi-label">Your BMI</div>
                        <div class="bmi-value" id="bmiValue">0.0</div>
                        <div class="bmi-category" id="bmiCategory">Normal</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('calculatorForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Get form values
            const age = parseInt(document.getElementById('age').value);
            const gender = document.querySelector('input[name="gender"]:checked').value;
            const weight = parseFloat(document.getElementById('weight').value);
            const height = parseInt(document.getElementById('height').value);
            const activity = parseFloat(document.querySelector('input[name="activity"]:checked').value);
            const goal = document.querySelector('input[name="goal"]:checked').value;

            // Calculate BMR using Mifflin-St Jeor equation
            let bmr;
            if (gender === 'male') {
                bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
            } else {
                bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
            }

            // Calculate TDEE
            let tdee = bmr * activity;

            // Adjust for goal
            let targetCalories;
            if (goal === 'cut') {
                targetCalories = tdee - 500; // 500 calorie deficit for cutting
            } else if (goal === 'bulk') {
                targetCalories = tdee + 300; // 300 calorie surplus for lean bulk
            } else {
                targetCalories = tdee; // Maintenance
            }

            // Calculate macros
            const proteinGrams = Math.round(weight * 2.2); // 2.2g per kg bodyweight
            const fatGrams = Math.round((targetCalories * 0.25) / 9); // 25% of calories from fat
            const carbGrams = Math.round((targetCalories - (proteinGrams * 4) - (fatGrams * 9)) / 4);

            // Calculate BMI
            const heightInMeters = height / 100;
            const bmi = (weight / (heightInMeters * heightInMeters)).toFixed(1);

            // Determine BMI category
            let bmiCategory, bmiColor;
            if (bmi < 18.5) {
                bmiCategory = 'Underweight';
                bmiColor = '#00d4ff';
            } else if (bmi < 25) {
                bmiCategory = 'Normal';
                bmiColor = '#00ff88';
            } else if (bmi < 30) {
                bmiCategory = 'Overweight';
                bmiColor = '#ffd700';
            } else {
                bmiCategory = 'Obese';
                bmiColor = '#ff4655';
            }

            // Update UI with results
            document.getElementById('totalCalories').textContent = Math.round(targetCalories);
            document.getElementById('proteinValue').textContent = proteinGrams;
            document.getElementById('carbsValue').textContent = carbGrams;
            document.getElementById('fatsValue').textContent = fatGrams;
            document.getElementById('bmiValue').textContent = bmi;
            document.getElementById('bmiCategory').textContent = bmiCategory;

            // Update BMI color
            document.getElementById('bmiValue').style.color = bmiColor;
            document.querySelector('.bmi-category').style.background = `${bmiColor}1a`;
            document.querySelector('.bmi-category').style.color = bmiColor;

            // Show results
            document.getElementById('resultsPlaceholder').style.display = 'none';
            document.getElementById('resultsContent').classList.add('show');
        });
    </script>
</body>
</html>