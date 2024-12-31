/^Impact: [0-9]+$/ { impact = $2 }
/^Confidence: [0-9]+$/ { confidence = $2 }
/^Ease: [0-9]+$/ { 
    ease = $2
    score = impact + confidence + ease
    if (title) print score, title
}
/^# / { title = substr($0, 3) }
